Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964995AbWCTVus@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964995AbWCTVus (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 16:50:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964997AbWCTVus
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 16:50:48 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:17282 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S964993AbWCTVur
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 16:50:47 -0500
Date: Mon, 20 Mar 2006 13:50:36 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Chris Wright <chrisw@sous-sol.org>, Dave Hansen <haveblue@us.ibm.com>,
       linux-kernel@vger.kernel.org, serue@us.ibm.com, frankeh@watson.ibm.com,
       clg@fr.ibm.com, Herbert Poetzl <herbert@13thfloor.at>,
       Sam Vilain <sam@vilain.net>
Subject: Re: [RFC][PATCH 2/6] sysvmsg: containerize
Message-ID: <20060320215036.GU15997@sorel.sous-sol.org>
References: <20060306235248.20842700@localhost.localdomain> <20060306235250.35676515@localhost.localdomain> <20060307015745.GG27645@sorel.sous-sol.org> <1141697323.9274.64.camel@localhost.localdomain> <20060307023445.GI27645@sorel.sous-sol.org> <m1r74ywinp.fsf@ebiederm.dsl.xmission.com> <20060320193414.GQ15997@sorel.sous-sol.org> <m1d5ggvm8y.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1d5ggvm8y.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Eric W. Biederman (ebiederm@xmission.com) wrote:
> Agreed.  Getting the limit checking correct without imposing measurable
> overhead is tricky.  My gut feel is that the limits should remain global
> until we can agree on how to implement more fine grained limits.

Sounds reasonable.
