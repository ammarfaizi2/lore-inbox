Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132517AbRDNSp3>; Sat, 14 Apr 2001 14:45:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132519AbRDNSpK>; Sat, 14 Apr 2001 14:45:10 -0400
Received: from a-pr9-44.tin.it ([212.216.147.171]:5248 "EHLO
	eris.discordia.loc") by vger.kernel.org with ESMTP
	id <S132517AbRDNSpB>; Sat, 14 Apr 2001 14:45:01 -0400
Date: Sat, 14 Apr 2001 20:45:25 +0200 (CEST)
From: Lorenzo Marcantonio <lomarcan@tin.it>
To: Nate Eldredge <neldredge@hmc.edu>
cc: <linux-kernel@vger.kernel.org>, <lomarcan@tin.it>
Subject: Re: SCSI Tape Corruption - update 2
In-Reply-To: <15063.8582.293619.762113@mercury.st.hmc.edu>
Message-ID: <Pine.LNX.4.31.0104142043340.1271-100000@eris.discordia.loc>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Apr 2001, Nate Eldredge wrote:

> (32 bytes is the size of a cache line.)  A memory tester might be
> something to try (I wrote a simple program that seemed to show the
> error better than memtest86; can send it if desired.)

Already tried that... this system has passed some 20 hours running
memtest86...

Also I've got NO OTHER memory failure symptom (and the tape fails only on
writing)

				-- Lorenzo Marcantonio

