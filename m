Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264915AbTCEJ0X>; Wed, 5 Mar 2003 04:26:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264984AbTCEJ0X>; Wed, 5 Mar 2003 04:26:23 -0500
Received: from 205-158-62-139.outblaze.com ([205.158.62.139]:57477 "HELO
	spf1.us.outblaze.com") by vger.kernel.org with SMTP
	id <S264915AbTCEJ0T>; Wed, 5 Mar 2003 04:26:19 -0500
Message-ID: <20030305093632.2454.qmail@linuxmail.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Paolo Ciarrocchi" <ciarrocchi@linuxmail.org>
To: linux-kernel@vger.kernel.org
Date: Wed, 05 Mar 2003 17:36:32 +0800
Subject: [BENCHMARK] dbench based
X-Originating-Ip: 193.76.202.244
X-Originating-Server: ws5-2.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
here are the results of a test based on dbench.
It runs dbench N three times and evaluate the average.

Something happened between 2.5.59 and 2.5.61.

Kernel version: report%2.4.19
2 	 46.6689
8 	 25.5343
16 	 20.7133
24 	 16.2473
32 	 14.2351

Kernel version: report%2.5.34
2 	 28.675
8 	 26.7106
16 	 21.0888
24 	 13.9644
32 	 12.6921

Kernel version: report%2.5.41
2 	 31.0127
8 	 32.0934
16 	 29.3058
24 	 20.291
32 	 19.157

Kernel version: report%2.5.42
2 	 29.8424
8 	 33.2596
16 	 27.0958
24 	 23.7237
32 	 20.4011

Kernel version: report%2.5.44
2 	 66.2467
8 	 32.0691
16 	 28.6565
24 	 20.3913
32 	 17.6516

Kernel version: report%2.5.45
2 	 44.8421
8 	 30.7749
16 	 26.6394
24 	 22.0835
32 	 17.3273

Kernel version: report%2.5.46
2 	 50.5605
8 	 32.2306
16 	 27.0133
24 	 22.4922
32 	 21.5183

Kernel version: report%2.5.53
2 	 50.4847
8 	 50.3427
16 	 36.5902
24 	 40.0419
32 	 35.5747

Kernel version: report%2.5.54bk4
2 	 46.7899
8 	 49.8274
16 	 41.2771
24 	 41.6313
32 	 39.2595

Kernel version: report%2.5.59
2 	 49.3527
8 	 47.5257
16 	 39.307
24 	 41.0944
32 	 35.264

Kernel version: report%2.5.61
2 	 47.9871
8 	 44.9921
16 	 32.549
24 	 27.1713
32 	 24.1933

Kernel version: report%2.5.62
2 	 62.2361
8 	 37.5537
16 	 30.384
24 	 22.9646
32 	 20.2702

Kernel version: report%2.5.63
2 	 61.2223
8 	 42.0958
16 	 30.3052
24 	 24.9342
32 	 19.6176

Kernel version: report%2.5.63-mjb2
2 	 59.8553
8 	 44.3926
16 	 32.0374
24 	 26.5789
32 	 23.7801

Ciao,
        Paolo

-- 
______________________________________________
http://www.linuxmail.org/
Now with e-mail forwarding for only US$5.95/yr

Powered by Outblaze
