Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293169AbSCEOIR>; Tue, 5 Mar 2002 09:08:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293155AbSCEOII>; Tue, 5 Mar 2002 09:08:08 -0500
Received: from flaske.stud.ntnu.no ([129.241.56.72]:4487 "EHLO
	flaske.stud.ntnu.no") by vger.kernel.org with ESMTP
	id <S293151AbSCEOH7>; Tue, 5 Mar 2002 09:07:59 -0500
Date: Tue, 5 Mar 2002 15:07:58 +0100
From: =?iso-8859-1?Q?Thomas_Lang=E5s?= <tlan@stud.ntnu.no>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org, jgarzik@mandrakesoft.com,
        linux-net@vger.kernel.org
Subject: Re: [BETA-0.95] Sixth test release of Tigon3 driver
Message-ID: <20020305150757.B7174@stud.ntnu.no>
Reply-To: linux-kernel@vger.kernel.org
In-Reply-To: <20020305143519.A1780@stud.ntnu.no> <20020305.055204.44939648.davem@redhat.com> <20020305150204.A7174@stud.ntnu.no> <20020305.060323.99455532.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020305.060323.99455532.davem@redhat.com>; from davem@redhat.com on Tue, Mar 05, 2002 at 06:03:23AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller:
> How are you setting the mtu, with:
> /sbin/ifconfig ${DEV} mtu 9000
> or something like that?  Hmmm...

ifconfig eth1 up mtu 9000

and 

ifconfig -a eth1 ... mtu 9000

both have been tried, no luck...

-- 
Thomas
