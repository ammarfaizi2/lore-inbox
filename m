Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262421AbSI2JAo>; Sun, 29 Sep 2002 05:00:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262422AbSI2JAo>; Sun, 29 Sep 2002 05:00:44 -0400
Received: from 205-158-62-105.outblaze.com ([205.158.62.105]:986 "HELO
	ws4-4.us4.outblaze.com") by vger.kernel.org with SMTP
	id <S262421AbSI2JAn>; Sun, 29 Sep 2002 05:00:43 -0400
Message-ID: <20020929090045.25295.qmail@linuxmail.org>
Content-Type: text/plain; charset="iso-8859-15"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Paolo Ciarrocchi" <ciarrocchi@linuxmail.org>
To: <conman@kolivas.net>
Cc: linux-kernel@vger.kernel.org
Date: Sun, 29 Sep 2002 17:00:45 +0800
Subject: Re: [BENCHMARK] 2.5.39 with contest 0.41
X-Originating-Ip: 193.76.202.244
X-Originating-Server: ws4-4.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Con Kolivas <conman@kolivas.net>
[...]
> > process_load:
> > Kernel                  Time            CPU             Ratio
> > 2.4.19                  200.43          60%             1.51
> > 2.4.19                  203.11          60%             1.53
> > 2.4.19                  203.97          59%             1.53
> > 2.5.38-mm2              194.42          69%             1.46
> > 2.5.38-mm2              195.19          69%             1.47
> > 2.5.38-mm2              207.36          64%             1.56
> > 2.5.39                  190.44          70%             1.43
> > 2.5.39                  191.37          70%             1.44
> > 2.5.39                  193.60          69%             1.45
> > 
> > io_load:
> > Kernel                  Time            CPU             Ratio
> > 2.4.19                  486.58          27%             3.66
> > 2.4.19                  593.72          22%             4.46
> > 2.4.19                  637.61          21%             4.79
> > 2.5.38-mm2              232.35          61%             1.75
> > 2.5.38-mm2              237.83          57%             1.79
> > 2.5.38-mm2              274.39          50%             2.06
> > 2.5.39                  242.98          57%             1.83
> > 2.5.39                  294.52          50%             2.21
> > 2.5.39                  328.01          42%             2.46
> > 
> > mem_load:
> > Kernel                  Time            CPU             Ratio
> > 2.4.19                  172.24          78%             1.29
> > 2.4.19                  174.74          77%             1.31
> > 2.4.19                  174.87          77%             1.31
> > 2.5.38-mm2              165.53          82%             1.24
> > 2.5.38-mm2              170.00          80%             1.28
> > 2.5.38-mm2              171.96          79%             1.29
> > 2.5.39                  167.92          81%             1.26
> > 2.5.39                  170.80          80%             1.28
> > 2.5.39                  172.68          79%             1.30
> 
> Quick statistical analysis:
> Noload, 2.5.39 is slower than 2.4.19 and same as 2.5.38-mm2
> 
> ProcessLoad, 2.5.39 is slower than 2.4.19 and same as 2.5.38-mm2
Why ? 
If look at the numbers I assume that 2.5.39 is faster then 2.4.19.
Am I missing something?

I'll run further test...

Ciao,
                Paolo
-- 
Get your free email from www.linuxmail.org 


Powered by Outblaze
