Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964802AbWGEKZi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964802AbWGEKZi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 06:25:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964799AbWGEKZi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 06:25:38 -0400
Received: from mail.clusterfs.com ([206.168.112.78]:18373 "EHLO
	mail.clusterfs.com") by vger.kernel.org with ESMTP id S964802AbWGEKZh
	(ORCPT <rfc822;Linux-Kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 06:25:37 -0400
From: Nikita Danilov <nikita@clusterfs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17579.37504.509233.959683@gargle.gargle.HOWL>
Date: Wed, 5 Jul 2006 14:20:48 +0400
To: "Bret Towe" <magnade@gmail.com>
Cc: "Ananiev, Leonid I" <leonid.i.ananiev@intel.com>,
       "Linux Kernel Mailing List" <Linux-Kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: moving dirty pages balancing to pdfludh entirely
In-Reply-To: <dda83e780607041524g5ae996fes6e579464a1af56ad@mail.gmail.com>
References: <B41635854730A14CA71C92B36EC22AAC06CCF2@mssmsx411>
	<17578.52643.364026.64265@gargle.gargle.HOWL>
	<dda83e780607041524g5ae996fes6e579464a1af56ad@mail.gmail.com>
X-Mailer: VM 7.17 under 21.5 (patch 17) "chayote" (+CVS-20040321) XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bret Towe writes:

[...]

 > 
 > are you sure about that? cause that sounded alot like an issue
 > i saw with slow usb devices (mainly a usb hd on a usb 1.1 connection)
 > the usb device would fill up with write queue and local io to say /dev/hda
 > would basicly stop and the system would be rather useless till the usb
 > hd would finish writing out what it was doing
 > usally would take several hundred megs of data to get it to do it

There may be bazillion other reasons for slow device making system
unresponsive in various ways. More details are needed (possibly in
separate thread).

 > 
 > ive not tried it in ages so maybe its been fixed since ive last tried it
 > dont recall the kernel version at the time but it wasnt more than a
 > year ago
 > 

Nikita.
