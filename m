Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273140AbRIJBmW>; Sun, 9 Sep 2001 21:42:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273135AbRIJBmM>; Sun, 9 Sep 2001 21:42:12 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:37647 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S273128AbRIJBmD>; Sun, 9 Sep 2001 21:42:03 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Booting linux using Novell NetWare Remote Program Loader
Date: 9 Sep 2001 18:41:52 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9nh5p0$3qt$1@cesium.transmeta.com>
In-Reply-To: <20010909220921.A19145@bug.ucw.cz> <20010909170206.A3245@redhat.com> <20010909230920.A23392@atrey.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20010909230920.A23392@atrey.karlin.mff.cuni.cz>
By author:    Pavel Machek <pavel@suse.cz>
In newsgroup: linux.dev.kernel
> 
> RPLD implements the IBM RIPL protocol, used to network boot some
> machines. It DOES NOT implement the Novell style RPL/IPX protocol.
> If your are not sure which protocol you are using see the section
> "Troubleshooting".
> 
> And, indeed, it does not work with Novell bootrom. If you have
> different version, please let me know...
> 

If someone has specs for these things I might give implementing it a
shot.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
