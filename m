Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274064AbRJQCp6>; Tue, 16 Oct 2001 22:45:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274244AbRJQCps>; Tue, 16 Oct 2001 22:45:48 -0400
Received: from paloma13.e0k.nbg-hannover.de ([62.159.219.13]:48869 "HELO
	paloma13.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S274064AbRJQCpd>; Tue, 16 Oct 2001 22:45:33 -0400
Content-Type: text/plain; charset=US-ASCII
From: Dieter =?iso-8859-15?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: marc.theaimsgroup.com SLOW or is it dead? Even no ping.
Date: Wed, 17 Oct 2001 04:45:30 +0200
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011017024540Z274064-17408+1384@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

ping gave me nothing:

/home/nuetzel> time ping marc.theaimsgroup.com
PING marc.theaimsgroup.com (63.238.77.237) from 217.227.7.38 : 56(84) bytes 
of data.

--- marc.theaimsgroup.com ping statistics ---
1587 packets transmitted, 0 received, 100% loss, time 1586439ms

0.000u 0.000s 26:36.39 0.0%     0+0k 0+0io 172pf+0w


Traceroute didn't look good, too:

/home/nuetzel> time traceroute marc.theaimsgroup.com
traceroute to marc.theaimsgroup.com (63.238.77.237), 30 hops max, 40 byte 
packets
 1  217.5.98.18 (217.5.98.18)  57 ms  56 ms  57 ms
 2  217.5.103.66 (217.5.103.66)  57 ms  56 ms  55 ms
 3  NYC-gw14.USA.net.DTAG.DE (62.156.131.138)  138 ms  139 ms  139 ms
 4  194.25.6.238 (194.25.6.238)  139 ms  138 ms  140 ms
 5  jfk-core-01.inet.qwest.net (205.171.30.13)  138 ms  139 ms  139 ms
 6  wdc-core-01.inet.qwest.net (205.171.5.236)  143 ms  144 ms  144 ms
 7  dca-core-02.inet.qwest.net (205.171.8.209)  144 ms  145 ms  142 ms
 8  atl-core-02.inet.qwest.net (205.171.8.153)  159 ms  160 ms  159 ms
 9  tpa-core-03.inet.qwest.net (205.171.5.65)  169 ms  170 ms  169 ms
10  * * *
11  208.47.124.146 (208.47.124.146)  184 ms  184 ms  184 ms
12  fw-dmz.theaimsgroup.com (63.237.12.11)  186 ms  185 ms  186 ms
13  * * *
14  * * *
15  * * *
16  * * *
17  * * *
18  * * *
19  * * *
20  * * *
21  * * *
22  * * *
23  * * *
24  * * *
25  * * *
26  * * *
27  * * *
28  * * *
29  * * *
30  * * *
0.010u 0.000s 2:56.37 0.0%      0+0k 0+0io 178pf+0w

What's up?
Or did I missing something?

Latest SuSE 7.3.

Thanks,
	Dieter

