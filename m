Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751636AbWDZDlc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751636AbWDZDlc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 23:41:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751637AbWDZDlc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 23:41:32 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:4831 "EHLO e36.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751635AbWDZDlb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 23:41:31 -0400
Date: Tue, 25 Apr 2006 17:00:22 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Sam Vilain <sam@vilain.net>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       "Serge E. Hallyn" <serue@us.ibm.com>, Kirill Korotaev <dev@sw.ru>,
       linux-kernel@vger.kernel.org, herbert@13thfloor.at, devel@openvz.org,
       xemul@sw.ru, James Morris <jmorris@namei.org>
Subject: Re: [RFC][PATCH 4/5] utsname namespaces: sysctl hack
Message-ID: <20060425220022.GD7228@sergelap.austin.ibm.com>
References: <20060407095132.455784000@sergelap> <20060407183600.E40C119B902@sergelap.hallyn.com> <4446547B.4080206@sw.ru> <m1wtdlmvmr.fsf@ebiederm.dsl.xmission.com> <20060419175123.GD1238@sergelap.austin.ibm.com> <m1ejztjua2.fsf@ebiederm.dsl.xmission.com> <4446AF56.9060706@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4446AF56.9060706@vilain.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sam Vilain (sam@vilain.net):
> Eric W. Biederman wrote:
> 
> >>Is it time to ask for the utsname namespace patch to be tried out
> >>in -mm?
> >>    
> >>
> >
> >Can we please suggest a syscall interface?

Eric,

Did you have any ideas for how you'd want to interface to look?  Are
you fine with the vserver approach?

> What was wrong with the method of the one I posted / extracted from the
> Linux-VServer project? I mean, apart from the baggage which I intend to
> remove for the next posting.

Sam,

Are you working on a next posting?

-serge
