Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314659AbSEFSmZ>; Mon, 6 May 2002 14:42:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314672AbSEFSmY>; Mon, 6 May 2002 14:42:24 -0400
Received: from hoemail1.lucent.com ([192.11.226.161]:11219 "EHLO
	hoemail1.firewall.lucent.com") by vger.kernel.org with ESMTP
	id <S314659AbSEFSmY>; Mon, 6 May 2002 14:42:24 -0400
From: John Stoffel <stoffel@casc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15574.52864.321544.44124@gargle.gargle.HOWL>
Date: Mon, 6 May 2002 14:42:08 -0400
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Cc: Dan Kegel <dank@kegel.com>, "David S. Miller" <davem@redhat.com>,
        <khttpd-users@alt.org>, <linux-kernel@vger.kernel.org>
Subject: Re: Tux in main kernel tree? (was khttpd rotten?)
In-Reply-To: <Pine.LNX.4.44.0205061608300.26867-100000@mustard.heime.net>
X-Mailer: VM 6.95 under Emacs 20.6.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Roy> Perhaps it's about time to talk about pulling Tux into the main
Roy> kernel tree, as khttpd once again has proved ususable.

And why does a Web server belong in the kernel?  I've never understood
this, and I personally do not think it has any need to be there.  

<sarcasm>

Or maybe we should include kDNS and kftpd as well now?

</sarcasm>

An httpd server is a *user space* issue, not a kernel issue.

John
   John Stoffel - Senior Unix Systems Administrator - Lucent Technologies
	 stoffel@lucent.com - http://www.lucent.com - 978-399-0479
