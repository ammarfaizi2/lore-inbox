Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273364AbRINLoN>; Fri, 14 Sep 2001 07:44:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273365AbRINLoE>; Fri, 14 Sep 2001 07:44:04 -0400
Received: from danielle.hinet.hr ([195.29.254.157]:1665 "EHLO
	danielle.hinet.hr") by vger.kernel.org with ESMTP
	id <S273364AbRINLny>; Fri, 14 Sep 2001 07:43:54 -0400
Date: Fri, 14 Sep 2001 13:44:15 +0200
From: Mario Mikocevic <mozgy@hinet.hr>
To: linux-kernel@vger.kernel.org
Subject: v2410p8 and v2410p9 are no go
Message-ID: <20010914134415.A802@danielle.hinet.hr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

kernels 2.4.10-pre8 and 2.4.10-pre9 are NoGo for me,
last kernel I tried and it still runs succesfully is 2.4.10-pre4.

dmesg difference is ->

- hda: [PTBL] [5171/240/63] hda1 hda2 hda3 hda4 < hda5 hda6 hda7 >
- hdd: [PTBL] [787/128/63] hdd1
+ hda: no partitions found
+ hdd: no partitions found


it's P4@1.4 w/ 256MiB RAM (HP Vectra).

Any further required info is available on requests.

-- 
Mario Mikoèeviæ (Mozgy)
mozgy at hinet dot hr
My favourite FUBAR ...
