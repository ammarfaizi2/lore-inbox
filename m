Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263868AbTLUTAU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Dec 2003 14:00:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263880AbTLUTAU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Dec 2003 14:00:20 -0500
Received: from louise.pinerecords.com ([213.168.176.16]:6876 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id S263868AbTLUTAQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Dec 2003 14:00:16 -0500
Date: Sun, 21 Dec 2003 19:59:59 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: Octave <oles@ovh.net>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org
Subject: Re: lot of VM problem with 2.4.23
Message-ID: <20031221185959.GE1494@louise.pinerecords.com>
References: <20031221001422.GD25043@ovh.net> <1071999003.2156.89.camel@abyss.local> <Pine.LNX.4.58L.0312211235010.6632@logos.cnet> <20031221184709.GO25043@ovh.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031221184709.GO25043@ovh.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Dec-21 2003, Sun, 19:47 +0100
Octave <oles@ovh.net> wrote:

> You can run this easy script. 2.4.19 takes about 30 minutes 
> to kill all process. 2.4.23 takes about 60 minutes.

Can you also try 2.4.24-pre1 with the OOM killer enabled?

-- 
Tomas Szepe <szepe@pinerecords.com>
