Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261568AbSKXSSc>; Sun, 24 Nov 2002 13:18:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261574AbSKXSSc>; Sun, 24 Nov 2002 13:18:32 -0500
Received: from 205-158-62-68.outblaze.com ([205.158.62.68]:19466 "HELO
	spf0.us4.outblaze.com") by vger.kernel.org with SMTP
	id <S261568AbSKXSSb>; Sun, 24 Nov 2002 13:18:31 -0500
Message-ID: <20021124182539.31423.qmail@linuxmail.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Paolo Ciarrocchi" <ciarrocchi@linuxmail.org>
To: linux-kernel@vger.kernel.org
Date: Mon, 25 Nov 2002 02:25:39 +0800
Subject: [Benchmark] Contest results (2.4.19 2.5.47 .48 .49)
X-Originating-Ip: 193.76.202.244
X-Originating-Server: ws5-1.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

$ cat /cygdrive/log/results.log

noload:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.19 [1]              133.3   98      0       0       1.00
2.5.47 [1]              138.3   96      0       0       1.04
2.5.48 [1]              138.0   96      0       0       1.03
2.5.49 [1]              137.9   96      0       0       1.03

process_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.19 [1]              223.3   57      183     43      1.67
2.5.47 [1]              210.2   63      75      37      1.58
2.5.48 [1]              214.5   62      79      38      1.61
2.5.49 [1]              208.9   63      74      37      1.57

ctar_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.19 [1]              169.8   80      3       9       1.27
2.5.47 [1]              170.8   82      3       9       1.28
2.5.48 [1]              170.7   82      3       9       1.28
2.5.49 [1]              171.4   82      3       9       1.29

xtar_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.19 [1]              208.7   65      4       10      1.57
2.5.47 [1]              185.0   73      3       8       1.39
2.5.48 [1]              183.9   74      3       8       1.38
2.5.49 [1]              187.5   72      3       9       1.41

io_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.19 [1]              961.5   14      100     13      7.21
2.5.47 [1]              254.9   54      22      12      1.91
2.5.48 [1]              220.8   62      18      12      1.66
2.5.49 [1]              224.8   60      20      13      1.69

read_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.19 [1]              189.2   72      15      5       1.42
2.5.47 [1]              167.5   82      10      5       1.26
2.5.48 [1]              168.8   82      13      6       1.27
2.5.49 [1]              167.4   82      11      5       1.26

list_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.19 [1]              149.1   89      0       6       1.12
2.5.47 [1]              158.7   85      0       9       1.19
2.5.48 [1]              158.3   85      0       9       1.19
2.5.49 [1]              156.6   86      0       9       1.17

mem_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.19 [1]              174.0   77      39      1       1.30
2.5.47 [1]              205.8   66      39      1       1.54
2.5.48 [1]              166.1   82      34      1       1.25
2.5.49 [1]              172.5   79      36      1       1.29
-- 
______________________________________________
http://www.linuxmail.org/
Now with POP3/IMAP access for only US$19.95/yr

Powered by Outblaze
