Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135535AbRA0VBT>; Sat, 27 Jan 2001 16:01:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135476AbRA0VBK>; Sat, 27 Jan 2001 16:01:10 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:23562 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S135457AbRA0VBE>;
	Sat, 27 Jan 2001 16:01:04 -0500
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200101272101.f0RL10k371976@saturn.cs.uml.edu>
Subject: Re: Renaming lost+found
To: NDias@sunglasshut.com
Date: Sat, 27 Jan 2001 16:01:00 -0500 (EST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <OF5807957D.5DF6F45B-ON852569E0.00783722@sunglasshut.com> from "NDias@sunglasshut.com" at Jan 26, 2001 05:09:59 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

NDias@sunglasshut.com writes:
> On 01/26/01 01:19 PM James Lewis Nance <jlnance@intrex.net> wrote:

>> FWIW IBM's JFS file system does not have a lost+found directory.  I dont
>> remember if reiserfs does or not.
> 
> Actually it does.
> 
> From one of my rs/6000's sitting here, with a pretty much default AIX

That is a completely different JFS.

AIX 4 has an encumbered JFS that is tightly integrated into
the VM system. IBM wrote a new JFS for OS/2 Warp Server.
The new JFS is being ported to Linux and AIX 5.

Grrrr.... should have called it jfs2 then.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
