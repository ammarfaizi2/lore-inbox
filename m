Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932534AbVLNNdM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932534AbVLNNdM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 08:33:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932533AbVLNNdM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 08:33:12 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:25860 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S932524AbVLNNdK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 08:33:10 -0500
Date: Tue, 14 Dec 2004 15:23:26 +0000
From: Pavel Machek <pavel@ucw.cz>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Dave Hansen <haveblue@us.ibm.com>,
       "SERGE E. HALLYN [imap]" <serue@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Hubertus Franke <frankeh@watson.ibm.com>, Paul Jackson <pj@sgi.com>
Subject: Re: [RFC] [PATCH 00/13] Introduce task_pid api
Message-ID: <20041214152325.GA2377@ucw.cz>
References: <20051114212341.724084000@sergelap> <m1slt5c6d8.fsf@ebiederm.dsl.xmission.com> <1133977623.24344.31.camel@localhost> <m1hd9kd89y.fsf@ebiederm.dsl.xmission.com> <1133991650.30387.17.camel@localhost> <m18xuwd015.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m18xuwd015.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> One of my wish list items would be to run my things like my
> web browser in a container with only access to a subset of
> the things I can normally access.  That way I could be less
> concerned about the latest browser security bug.

subterfugue.sf.net (using ptrace), but yes, nicer solution
would be welcome.

-- 
Thanks, Sharp!
