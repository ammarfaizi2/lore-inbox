Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161164AbWAKCFq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161164AbWAKCFq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 21:05:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161152AbWAKCFq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 21:05:46 -0500
Received: from ra.tuxdriver.com ([24.172.12.4]:46853 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S1161143AbWAKCFp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 21:05:45 -0500
Date: Tue, 10 Jan 2006 21:05:36 -0500
From: "John W. Linville" <linville@tuxdriver.com>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: Wireless: One small step towards a more perfect union...?
Message-ID: <20060111020534.GA22285@tuxdriver.com>
Mail-Followup-To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20060106042218.GA18974@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060106042218.GA18974@havoc.gtf.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A few days ago, Jeff Garzik reminded us all of the grossly imperfect
state of wireless (802.11 aka WiFi) networking in Linux.  First in
his list of key issues was the lack of a permanent maintainer for the
kernel wireless code.  Jeff approached me to see if I was interested
in that role, and after some discussions with Jeff and others I have
agreed to assume it.  Consequently...

I hereby claim responsibility for the state of wireless networking
support in the Linux kernel.

By that statement I do not mean to claim credit for that which has
already been done.  Nor do I shoulder the blame for any missteps which
have occurred to date.  I simply mean that I intend to do my best to
improve the wireless networking support in Linux at an observable rate
for the foreseeable future.  I intend to do that both through my own
work and through facilitating and/or coordinating the work of others.
I intend to do so with the ultimate goal of achieving the same sort of
"best of breed" networking support for wireless that Linux already
enjoys in traditional networking technologies.  I hope that I can
count on all of you for development, testing, and/or moral support
in that endeavour.

Who am I?

Hopefully many of you recognize me through my upstream contributions.
Others may have seen some of my work with Fedora and/or RHEL
(http://people.redhat.com/linville/).  My recent announcement of
the Fedora-netdev line of kernels seems to have drawn a fair amount
of publicity.

Beyond that, I have spent a decade or so in networking, mostly with
LAN switches.  I have good experience with LAN technologies, including
Token Ring, ATM, and especially Ethernet.  I have considerably less
experience with 802.11, but I am building on that as quickly as I can.
I have no doubt that there are many with more 802.11 expertise than
I have.  Still, I believe that I have enough expertise to combine with
my judgment and experience in order to carry-out this duty effectively.

Maintenance Plans

I will, of course, establish a public GIT tree to act as a repository
for wireless development.  I have requested space at kernel.org, and
I will announce that location once the tree is established.  In the
meantime, please copy me on any wireless and/or wireless-related
patches you may submit to make sure that I see them.

If you are the maintainer of an out-of-tree driver or other component
(e.g. softmac), please let me hear from you (publicly or privately).
I want to be sure to identify all the major stakeholders.  I would
also like to hear your plans for getting your code into the tree... :-)

I realize there are some burning issues at the moment, especially the
DeviceScape vs. ieee80211 stack wars.  I do not intend to pronounce
summary judgment on any issues here or in the immediate future.
Please do copy me on any important discussions, and feel free to
invite me into any pertinent mailing lists or IRC channels.  I would
also love to hear about any ongoing projects, even if they may not
be ready to be discussed publicly.

Once again, I appreciate your support in this.  I thank Jeff for the
role he has played to date and the role he will continue to play.
Likewise I thank all of the wireless contributors, including driver,
stack, and userland tool maintainers.  I hope to enjoy your continued
contributions and your support.

May the Force be with us!

John
-- 
John W. Linville
linville@tuxdriver.com
