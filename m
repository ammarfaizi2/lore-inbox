Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161358AbWHDSDM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161358AbWHDSDM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 14:03:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161359AbWHDSDM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 14:03:12 -0400
Received: from main.gmane.org ([80.91.229.2]:39602 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1161358AbWHDSDL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 14:03:11 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Ben Pfaff <blp@cs.stanford.edu>
Subject: Re: [PATCH -mm] [2/3] add list_merge to list.h
Date: Fri, 04 Aug 2006 11:03:11 -0700
Message-ID: <87mzakv0o0.fsf@benpfaff.org>
References: <5c49b0ed0608031915g2c1fc44ch623a7657b994bf9c@mail.gmail.com>
Reply-To: blp@cs.stanford.edu
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: c-24-7-50-23.hsd1.ca.comcast.net
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Cancel-Lock: sha1:MMWEiojLRiBwLMF0XIe3IX+WOXk=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Nate Diller" <nate.diller@gmail.com> writes:

> + * This is similar to list_splice(), except it merges every item onto @list,
> + * not excluding @head itself.  It is a noop if @head already immediately
> + * preceeds @list.

"not excluding"?  Is that the same as "including"?
-- 
Ben Pfaff 
email: blp@cs.stanford.edu
web: http://benpfaff.org

