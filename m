Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262422AbSI2JLo>; Sun, 29 Sep 2002 05:11:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262423AbSI2JLo>; Sun, 29 Sep 2002 05:11:44 -0400
Received: from c16598.thoms1.vic.optusnet.com.au ([210.49.243.217]:20686 "HELO
	pc.kolivas.net") by vger.kernel.org with SMTP id <S262422AbSI2JLn>;
	Sun, 29 Sep 2002 05:11:43 -0400
Message-ID: <1033291023.3d96c50f800e4@kolivas.net>
Date: Sun, 29 Sep 2002 19:17:03 +1000
From: Con Kolivas <conman@kolivas.net>
To: Paolo Ciarrocchi <ciarrocchi@linuxmail.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BENCHMARK] 2.5.39 with contest 0.41
References: <20020929090045.25295.qmail@linuxmail.org>
In-Reply-To: <20020929090045.25295.qmail@linuxmail.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Paolo Ciarrocchi <ciarrocchi@linuxmail.org>:

> From: Con Kolivas <conman@kolivas.net>
> [...]
> > > process_load:
> > > Kernel                  Time            CPU             Ratio
> > > 2.4.19                  200.43          60%             1.51
> > > 2.4.19                  203.11          60%             1.53
> > > 2.4.19                  203.97          59%             1.53
> > > 2.5.38-mm2              194.42          69%             1.46
> > > 2.5.38-mm2              195.19          69%             1.47
> > > 2.5.38-mm2              207.36          64%             1.56
> > > 2.5.39                  190.44          70%             1.43
> > > 2.5.39                  191.37          70%             1.44
> > > 2.5.39                  193.60          69%             1.45
> > > 
> > > io_load:
> > > Kernel                  Time            CPU             Ratio
> > > 2.4.19                  486.58          27%             3.66
> > > 2.4.19                  593.72          22%             4.46
> > > 2.4.19                  637.61          21%             4.79
> > > 2.5.38-mm2              232.35          61%             1.75
> > > 2.5.38-mm2              237.83          57%             1.79
> > > 2.5.38-mm2              274.39          50%             2.06
> > > 2.5.39                  242.98          57%             1.83
> > > 2.5.39                  294.52          50%             2.21
> > > 2.5.39                  328.01          42%             2.46
> > > 
> > > mem_load:
> > > Kernel                  Time            CPU             Ratio
> > > 2.4.19                  172.24          78%             1.29
> > > 2.4.19                  174.74          77%             1.31
> > > 2.4.19                  174.87          77%             1.31
> > > 2.5.38-mm2              165.53          82%             1.24
> > > 2.5.38-mm2              170.00          80%             1.28
> > > 2.5.38-mm2              171.96          79%             1.29
> > > 2.5.39                  167.92          81%             1.26
> > > 2.5.39                  170.80          80%             1.28
> > > 2.5.39                  172.68          79%             1.30
> > 
> > Quick statistical analysis:
> > Noload, 2.5.39 is slower than 2.4.19 and same as 2.5.38-mm2
> > 
> > ProcessLoad, 2.5.39 is slower than 2.4.19 and same as 2.5.38-mm2
> Why ? 
> If look at the numbers I assume that 2.5.39 is faster then 2.4.19.
> Am I missing something?

Sorry, typo should read 2.5.39 is faster than 2.4.19 and same as 2.5.38-mm2

> I'll run further test...

Not really needed. I'm convinced the difference is there, and the people who can
act on the data probably will be happy with that much information too. Some are
less satisfied with the quality of the data unless there is firm statistical
data to support the hypothesis. Your time is better spent on other things.

Con
