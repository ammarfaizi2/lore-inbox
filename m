Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261186AbVCQVWN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261186AbVCQVWN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 16:22:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261193AbVCQVWN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 16:22:13 -0500
Received: from pfepc.post.tele.dk ([195.41.46.237]:61957 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S261186AbVCQVWJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 16:22:09 -0500
Date: Thu, 17 Mar 2005 22:23:02 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: domen@coderock.org
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, nikai@nikai.net
Subject: Re: [patch 12/12] scripts/mod/sumversion.c: replace strtok() with strsep()
Message-ID: <20050317212302.GB13119@mars.ravnborg.org>
References: <20050305153545.9769F1F1F0@trashy.coderock.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050305153545.9769F1F1F0@trashy.coderock.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 05, 2005 at 04:35:45PM +0100, domen@coderock.org wrote:
> 
> Replaces strtok() with strsep()

Why - does it increase portability?

	Sam
