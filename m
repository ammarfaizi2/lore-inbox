Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267059AbTAFRqK>; Mon, 6 Jan 2003 12:46:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267057AbTAFRqK>; Mon, 6 Jan 2003 12:46:10 -0500
Received: from louise.pinerecords.com ([213.168.176.16]:43727 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S267059AbTAFRqJ>; Mon, 6 Jan 2003 12:46:09 -0500
Date: Mon, 6 Jan 2003 18:54:43 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: John Bradford <john@grabjohn.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel configurator request
Message-ID: <20030106175443.GP5984@louise.pinerecords.com>
References: <200301061725.h06HP8Ur000947@darkstar.example.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200301061725.h06HP8Ur000947@darkstar.example.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [john@grabjohn.com]
> 
> Obviously I can work around this, but it would seem to me to be better
> to have the kernel configurators generate .config files like this:
> 
> #
> # Automatically generated make config: don't edit
> #
> 
> #
> # Very general options
> #
> [Very general options]

[snip]

John,

AFAIK all you have to do to make this reality is add a "comment" clause
where you need it.

-- 
Tomas Szepe <szepe@pinerecords.com>
