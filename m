Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265177AbTFMGjy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 02:39:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265178AbTFMGjy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 02:39:54 -0400
Received: from smtp-out.comcast.net ([24.153.64.116]:12341 "EHLO
	smtp-out.comcast.net") by vger.kernel.org with ESMTP
	id S265177AbTFMGjx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 02:39:53 -0400
Date: Thu, 12 Jun 2003 23:53:36 -0700
From: "H. J. Lu" <hjl@lucon.org>
Subject: Re: PATCH: 2.5.70: Export set_fs_root and set_fs_pwd
In-reply-to: <20030613074607.A5830@infradead.org>
To: Christoph Hellwig <hch@infradead.org>,
       linux kernel <linux-kernel@vger.kernel.org>
Message-id: <20030613065336.GA28517@lucon.org>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: Mutt/1.4.1i
References: <20030613054228.GA27470@lucon.org>
 <20030613074607.A5830@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 13, 2003 at 07:46:07AM +0100, Christoph Hellwig wrote:
> On Thu, Jun 12, 2003 at 10:42:28PM -0700, H. J. Lu wrote:
> > In 2.5.70, intermezzo fs can be configured as module. But intermezzo
> > references set_fs_root and set_fs_pwd:
> 
> I'd rather see a very good reason why intermezzo needs this first.

I have no idea. I just happened to configure intermezzo as a module
and it failed.


H.J.
