Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262752AbVFWV2R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262752AbVFWV2R (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 17:28:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262717AbVFWVW1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 17:22:27 -0400
Received: from [80.71.243.242] ([80.71.243.242]:61312 "EHLO tau.rusteko.ru")
	by vger.kernel.org with ESMTP id S262711AbVFWVSF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 17:18:05 -0400
From: Nikita Danilov <nikita@clusterfs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17083.9995.105576.61184@gargle.gargle.HOWL>
Date: Fri, 24 Jun 2005 01:18:03 +0400
To: Hans Reiser <reiser@namesys.com>
Cc: Pekka Enberg <penberg@gmail.com>, Alexander Zarochentcev <zam@namesys.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: -mm -> 2.6.13 merge status
Newsgroups: gmane.comp.file-systems.reiserfs.general,gmane.linux.kernel
In-Reply-To: <42BAEEA1.2060305@namesys.com>
References: <20050620235458.5b437274.akpm@osdl.org.suse.lists.linux.kernel>
	<p73d5qgc67h.fsf@verdi.suse.de>
	<42B86027.3090001@namesys.com>
	<20050621195642.GD14251@wotan.suse.de>
	<42B8C0FF.2010800@namesys.com>
	<84144f0205062223226d560e41@mail.gmail.com>
	<42BA67C9.7060604@namesys.com>
	<1119543302.4115.141.camel@tribesman.namesys.com>
	<42BAEEA1.2060305@namesys.com>
X-Mailer: VM 7.17 under 21.5 (patch 17) "chayote" (+CVS-20040321) XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans Reiser writes:

[...]

 > I think the above is easier to read than the below.  Macros can obscure
 > sometimes, and one of our weaknesses is a tendency to use macros in such
 > a way that it frustrates meta-. use in emacs.   Nikita did however
 > mention that there was something that could understand macros when
 > constructing tags files, but I forgot what that was.

xref.el (http://xref-tech.com/xrefactory/main.html). With it one can
type current->[TAB] and it shows fields of struct task_struct in the
emacs completion buffer.

Nikita.
