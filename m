Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264054AbRFER05>; Tue, 5 Jun 2001 13:26:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264057AbRFER0r>; Tue, 5 Jun 2001 13:26:47 -0400
Received: from apegate.roma1.infn.it ([141.108.7.31]:27120 "EHLO sensei.ape")
	by vger.kernel.org with ESMTP id <S264054AbRFER02>;
	Tue, 5 Jun 2001 13:26:28 -0400
Date: Tue, 5 Jun 2001 19:26:23 +0200 (CEST)
From: "davide.rossetti" <rossetti@roma1.infn.it>
Reply-To: <davide.rossetti@roma1.infn.it>
To: Mihai Moise <mmoise@giref.ulaval.ca>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: semaphores and noatomic flag
In-Reply-To: <3B1BC6BF.8098111A@giref.ulaval.ca>
Message-ID: <Pine.LNX.4.33.0106051923560.1901-100000@sensei.ape>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

whould it be possible to use pthread semaphore/mutex/cond_var on
shared-via-mmap() chunks of memory instead ?

regards

-- 
+------------------------------------------------------------------+
|Rossetti Davide   INFN - Sezione Roma I - gruppo V, prog. APEmille|
|                  web    : http://apegate.roma1.infn.it/~rossetti |
|    """""         E-mail : davide.rossetti@roma1.infn.it          |
|    |o o|         phone  : (+39)-06-49914412                      |
|--o00O-O00o--     fax    : (+39)-06-49914423   (+39)-06-4957697   |
|                  address: Dipartimento di Fisica (V.E.)          |
|                           Universita' di Roma "La Sapienza"      |
|                           P.le Aldo Moro,5 I - 00185 Roma - Italy|
|  gnupg pub. key: http://apegate.roma1.infn.it/~rossetti/gnupg.txt|
|								   |
|"Outside of a dog,a book is a man's best friend. Inside of a dog, |
| it's too dark to read." - Groucho Marx                           |
+------------------------------------------------------------------+

