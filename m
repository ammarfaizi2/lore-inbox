Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262803AbTJDXPS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Oct 2003 19:15:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262804AbTJDXPS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Oct 2003 19:15:18 -0400
Received: from pizda.ninka.net ([216.101.162.242]:45998 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S262803AbTJDXPQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Oct 2003 19:15:16 -0400
Date: Sat, 4 Oct 2003 16:10:37 -0700
From: "David S. Miller" <davem@redhat.com>
To: Vishwas Raman <vishwas@eternal-systems.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Accessing tcp socket information from within a module
Message-Id: <20031004161037.05b9e5ee.davem@redhat.com>
In-Reply-To: <3F7F5294.1090606@eternal-systems.com>
References: <3F7E0DFF.2030404@eternal-systems.com>
	<20031003225124.17a440c2.davem@redhat.com>
	<3F7F5294.1090606@eternal-systems.com>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 04 Oct 2003 16:07:00 -0700
Vishwas Raman <vishwas@eternal-systems.com> wrote:

> And I need to get info on all TCP 
> sockets and create/modify certain data structures of my own in the 
> module based on that information.

Well, then, you're going to have to study and learn the entire
TCP stack in order to learn how to do this and furthermore to be
able to do this safely.

I'm a bit skeptical of what you actually want to use this for,
so I'm going to choose not to help you with this until you give
some more details of what you're exactly up to.
