Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317482AbSGEPeV>; Fri, 5 Jul 2002 11:34:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317494AbSGEPeU>; Fri, 5 Jul 2002 11:34:20 -0400
Received: from B5578.pppool.de ([213.7.85.120]:45837 "EHLO
	nicole.de.interearth.com") by vger.kernel.org with ESMTP
	id <S317482AbSGEPeQ>; Fri, 5 Jul 2002 11:34:16 -0400
Subject: Re: IBM Desktar disk problem?
From: Daniel Egger <degger@fhm.edu>
To: Tomas Konir <moje@molly.vabo.cz>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44L0.0207051643580.709-100000@moje.ich.vabo.cz>
References: <Pine.LNX.4.43.0207051524480.9092-100000@cibs9.sns.it>
	<Pine.LNX.4.44L0.0207051606050.32493-100000@moje.ich.vabo.cz>
	<20020705142619.GN1007@suse.de> 
	<Pine.LNX.4.44L0.0207051643580.709-100000@moje.ich.vabo.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.7 
Date: 05 Jul 2002 17:38:31 +0200
Message-Id: <1025883512.17296.28.camel@sonja.de.interearth.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Fre, 2002-07-05 um 16.48 schrieb Tomas Konir:

> Error Log Structure 1:
> DCR   FR   SC   SN   CL   SH   D/H   CR   Timestamp
>  00   08   80   ee   88   a2    e0   cc     1210341
>  00   08   08   ee   88   a2    e0   a2     1210341
>  00   08   87   04   1d   20    e0   cc     1210341
>  00   00   00   04   1d   20    e0   00     1210341
>  00   00   80   06   42   67    e1   c8     1210341
>  00   84   00   85   42   67    e1   51     0
> Error condition:   0    Error State:       3
 
> Error Log Structure 2:
> DCR   FR   SC   SN   CL   SH   D/H   CR   Timestamp
>  00   80   00   3e   66   23    e1   c7     1386233
>  00   80   08   3e   66   23    e0   a2     1386233
>  00   80   30   be   66   23    e1   c7     1386233
>  00   80   80   be   66   23    e1   c4     1386233
>  00   08   08   26   32   a4    e0   cc     1386237
>  00   84   00   2d   32   a4    e0   51     0
> Error condition:   0    Error State:       3

Not good. Check for the "Reallocated Sector Ct".
 
-- 
Servus,
       Daniel

