Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261493AbVFAReC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261493AbVFAReC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 13:34:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261482AbVFARbh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 13:31:37 -0400
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:36555 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S261481AbVFARat (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 13:30:49 -0400
Message-ID: <429DF038.3010503@nortel.com>
Date: Wed, 01 Jun 2005 11:28:24 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
CC: dtor_core@ameritech.net, toon@hout.vanvergehaald.nl, mrmacman_g4@mac.com,
       ltd@cisco.com, linux-kernel@vger.kernel.org, 7eggert@gmx.de
Subject: Re: OT] Joerg Schilling flames Linux on his Blog
References: <26A66BC731DAB741837AF6B2E29C10171E60DE@xmb-hkg-413.apac.cisco.com> <20050530093420.GB15347@hout.vanvergehaald.nl> <429B0683.nail5764GYTVC@burner> <46BE0C64-1246-4259-914B-379071712F01@mac.com> <429C4483.nail5X0215WJQ@burner> <20050531172204.GD17338@voodoo> <d120d500050531122879868bae@mail.gmail.com> <429DDA07.nail7BFA4XEC5@burner> <d120d50005060109051f9ade82@mail.gmail.com> <429DEA5B.nail7BFNJVI78@burner>
In-Reply-To: <429DEA5B.nail7BFNJVI78@burner>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joerg Schilling wrote:

> There is still no new and definitely stable interface that allows me to
> asume that it makes sense to put effort in implementing support for it.

Why not just accept *any* device node that the user passes in?

I fail to see why it matters what the device name is as long as it 
accepts the required ioctl() commands.

Chris
