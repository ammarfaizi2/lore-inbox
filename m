Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270340AbUJTKBb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270340AbUJTKBb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 06:01:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270276AbUJTJ4p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 05:56:45 -0400
Received: from pimout2-ext.prodigy.net ([207.115.63.101]:64441 "EHLO
	pimout2-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S270067AbUJTJul (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 05:50:41 -0400
Date: Wed, 20 Oct 2004 02:49:35 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Andrew Morton <akpm@osdl.org>, Jeff Dike <jdike@karaya.com>,
       linux-kernel@vger.kernel.org
Subject: Re: generic hardirq handling for uml
Message-ID: <20041020094935.GA6481@taniwha.stupidest.org>
References: <20041020001124.GA29215@admingilde.org> <20041020031826.GA9966@taniwha.stupidest.org> <20041020094638.GH3618@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041020094638.GH3618@admingilde.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 20, 2004 at 11:46:38AM +0200, Martin Waitz wrote:

> I guess I'll use your patch for further tests :)

it's as clean as it could be yet --- i wanted to make the smallest
diff possible until more of the UML gets merged then i'll do another
pass trimming lots of cruft out
