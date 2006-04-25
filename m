Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751017AbWDYSjA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751017AbWDYSjA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 14:39:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751016AbWDYSjA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 14:39:00 -0400
Received: from fw5.argo.co.il ([194.90.79.130]:14344 "EHLO argo2k.argo.co.il")
	by vger.kernel.org with ESMTP id S1750718AbWDYSjA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 14:39:00 -0400
Message-ID: <444E6CBD.5020904@argo.co.il>
Date: Tue, 25 Apr 2006 21:38:53 +0300
From: Avi Kivity <avi@argo.co.il>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Valdis.Kletnieks@vt.edu
CC: dtor_core@ameritech.net, Kyle Moffett <mrmacman_g4@mac.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Compiling C++ modules
References: <B9FF2DE8-2FE8-4FE1-8720-22FE7B923CF8@iomega.com> <1145911546.1635.54.camel@localhost.localdomain> <444D3D32.1010104@argo.co.il> <A6E165E4-8D43-4CF8-B48C-D4B0B28498FB@mac.com> <444DCAD2.4050906@argo.co.il> <9E05E1FA-BEC8-4FA8-811E-93CBAE4D47D5@mac.com> <444E524A.10906@argo.co.il> <d120d5000604251010kd56580fl37a0d244da1eaf45@mail.gmail.com> <444E5A3E.1020302@argo.co.il> <d120d5000604251028h67e552ccq7084986db6f1cdeb@mail.gmail.com> <444E61FD.7070408@argo.co.il> <200604251808.k3PI8Y06004736@turing-police.cc.vt.edu> <444E69E7.7020808@argo.co.il>
In-Reply-To: <444E69E7.7020808@argo.co.il>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 25 Apr 2006 18:38:56.0982 (UTC) FILETIME=[82C33760:01C66897]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Avi Kivity wrote:
>
> [avi@cleopatra linux]$ grep -r out.*: . | wc -l
> 10446
>
Not to mention:

[avi@cleopatra linux]$ grep -rw goto . | wc -l
37448

How many of these leave something out? how much time is spent 
deciphering the code when something goes wrong, or is even suspected?


-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.

