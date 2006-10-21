Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992765AbWJUAr4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992765AbWJUAr4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 20:47:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992763AbWJUArz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 20:47:55 -0400
Received: from relais.videotron.ca ([24.201.245.36]:19888 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S2992761AbWJUArz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 20:47:55 -0400
Date: Fri, 20 Oct 2006 20:47:54 -0400 (EDT)
From: Nicolas Pitre <nico@cam.org>
Subject: Re: [ANNOUNCE] GIT 1.4.3
In-reply-to: <7v4ptylfvw.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@xanadu.home
To: Junio C Hamano <junkio@cox.net>
Cc: git@vger.kernel.org, linux-kernel@vger.kernel.org
Message-id: <Pine.LNX.4.64.0610202046420.12418@xanadu.home>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT
References: <7vejt5xjt9.fsf@assigned-by-dhcp.cox.net>
 <7v4ptylfvw.fsf@assigned-by-dhcp.cox.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Oct 2006, Junio C Hamano wrote:

> Junio C Hamano <junkio@cox.net> writes:
> 
> >  - git-diff paginates its output to the tty by default.  If this
> >    irritates you, using LESS=RF might help.
> 
> I am considering the following to address irritation some people
> (including me, actually) are experiencing with this change when
> viewing a small (or no) diff.  Any objections?

I think this is an excellent idea.


Nicolas
