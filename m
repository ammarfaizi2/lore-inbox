Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261880AbUKCUzF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261880AbUKCUzF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 15:55:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261876AbUKCUxA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 15:53:00 -0500
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36]:24680 "HELO
	smtp005.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S261879AbUKCUvZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 15:51:25 -0500
From: Blaisorblade <blaisorblade_spam@yahoo.it>
To: user-mode-linux-user@lists.sourceforge.net
Subject: Re: [uml-user] Harddisk Shutdown while UML Guest Shutdown
Date: Wed, 3 Nov 2004 21:51:30 +0100
User-Agent: KMail/1.7.1
Cc: Roland Kaeser <roli8200@yahoo.de>, LKML <linux-kernel@vger.kernel.org>
References: <20041103194142.36592.qmail@web26110.mail.ukl.yahoo.com>
In-Reply-To: <20041103194142.36592.qmail@web26110.mail.ukl.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411032151.30147.blaisorblade_spam@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 03 November 2004 20:41, Roland Kaeser wrote:
> Hello
>
> I've forgotten one point. The guest kernel creates a (how is the correct
> english word for this?) a memory error (German Speicherfehler) so it seems
> that the kernel crashes. I have to say that I run the guest system with
> root privileges (on the root account).
Could you first try running it on a normal account? If that workarounds the 
problem, then the second try goes to trying a different root_fs.

-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
