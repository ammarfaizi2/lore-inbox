Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964853AbVKGPr2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964853AbVKGPr2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 10:47:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964830AbVKGPr2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 10:47:28 -0500
Received: from 193.37.26.69.virtela.com ([69.26.37.193]:49792 "EHLO
	teapot.corp.reactrix.com") by vger.kernel.org with ESMTP
	id S964850AbVKGPr1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 10:47:27 -0500
Date: Mon, 7 Nov 2005 07:47:18 -0800
From: Nick Hengeveld <nickh@reactrix.com>
To: Junio C Hamano <junkio@cox.net>
Cc: git@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: GIT 0.99.9e
Message-ID: <20051107154718.GJ3001@reactrix.com>
References: <7v64r5t3m0.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7v64r5t3m0.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 06, 2005 at 09:43:19PM -0800, Junio C Hamano wrote:

>  - http-push seems to still have a bug or two but that is to be
>    expected for any new code, and I am reasonably sure it can be
>    ironed out; preferably before 1.0 but it is not a
>    showstopper.

It seems like a minor point, but is this the appropriate name or should
it be dav-push?  Not that there's anything else in the works AFAIK but
it's certainly possible that something else could run over HTTP later
on.

-- 
For a successful technology, reality must take precedence over public
relations, for nature cannot be fooled.
