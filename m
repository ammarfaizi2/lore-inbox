Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261262AbULWUWj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261262AbULWUWj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Dec 2004 15:22:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261288AbULWUWj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Dec 2004 15:22:39 -0500
Received: from pfepa.post.tele.dk ([195.41.46.235]:14738 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S261262AbULWUWh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Dec 2004 15:22:37 -0500
Date: Thu, 23 Dec 2004 21:22:57 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Park Lee <parklee_sel@yahoo.com>
Cc: twaugh@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: Something wrong when transform Documentation/DocBook/*.tmpl into pdf
Message-ID: <20041223202257.GA8631@mars.ravnborg.org>
Mail-Followup-To: Park Lee <parklee_sel@yahoo.com>,
	twaugh@redhat.com, linux-kernel@vger.kernel.org
References: <20041223193925.57234.qmail@web51501.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041223193925.57234.qmail@web51501.mail.yahoo.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 23, 2004 at 11:39:25AM -0800, Park Lee wrote:
 
>   Then, on the command line, I type the following
> commands:
> 
> cd /usr/src/linux-2.6.5-1.358/Documentation/DocBook 
> <ENTER>
> make pdfdocs  <ENTER>

Execute the command from the root of the kernel src:
cd /usr/src/linux-2.6.5-1.358/
make pdfdocs

	Sam
