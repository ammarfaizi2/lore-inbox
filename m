Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266379AbUHMSIW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266379AbUHMSIW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 14:08:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266380AbUHMSIW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 14:08:22 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:56594 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S266379AbUHMSIV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 14:08:21 -0400
Date: Fri, 13 Aug 2004 20:10:42 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: "David S. Miller" <davem@redhat.com>, Sam Ravnborg <sam@ravnborg.org>,
       torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH]: __crc_* symbols in System.map
Message-ID: <20040813181042.GA9006@mars.ravnborg.org>
Mail-Followup-To: "David S. Miller" <davem@redhat.com>,
	Sam Ravnborg <sam@ravnborg.org>, torvalds@osdl.org, akpm@osdl.org,
	linux-kernel@vger.kernel.org
References: <20040811205529.1ff86e9d.davem@redhat.com> <20040812050136.GA7246@mars.ravnborg.org> <20040812000558.220d7e5d.davem@redhat.com> <20040813180239.GA7571@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040813180239.GA7571@mars.ravnborg.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 13, 2004 at 08:02:39PM +0200, Sam Ravnborg wrote:
> 
> $NM -n $1 | grep  '\( [aUw] \)\|\(__crc_\)' > $2

The missing -v ito grep was just to check if you were awake :-(

	Sam
