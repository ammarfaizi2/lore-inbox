Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751344AbWAVUjz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751344AbWAVUjz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jan 2006 15:39:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751346AbWAVUjz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jan 2006 15:39:55 -0500
Received: from elvis.mu.org ([192.203.228.196]:47584 "EHLO elvis.mu.org")
	by vger.kernel.org with ESMTP id S1751344AbWAVUjy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jan 2006 15:39:54 -0500
Message-ID: <43D3ED8A.3070606@FreeBSD.org>
Date: Sun, 22 Jan 2006 12:39:38 -0800
From: Suleiman Souhlal <ssouhlal@FreeBSD.org>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051204)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Diego Calleja <diegocg@gmail.com>
CC: "Theodore Ts'o" <tytso@mit.edu>, nigelenki@comcast.net,
       linux-kernel@vger.kernel.org
Subject: Re: soft update vs journaling?
References: <43D3295E.8040702@comcast.net>	<20060122093144.GA7127@thunk.org> <20060122205039.e8842bae.diegocg@gmail.com>
In-Reply-To: <20060122205039.e8842bae.diegocg@gmail.com>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Diego Calleja wrote:
> And FreeBSD is implementing journaling for UFS and getting rid of 
> softupdates [1]. While this not proves that softupdates is "a bad idea",
> i think this proves why the added sofupdates complexity doesn't seem
> to pay off in the real world. 

You read the message wrong: We're not getting rid of softupdates.
-- Suleiman
