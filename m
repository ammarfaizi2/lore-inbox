Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262000AbSJIUxC>; Wed, 9 Oct 2002 16:53:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262042AbSJIUxC>; Wed, 9 Oct 2002 16:53:02 -0400
Received: from mx1.elte.hu ([157.181.1.137]:22479 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S262000AbSJIUxC>;
	Wed, 9 Oct 2002 16:53:02 -0400
Date: Wed, 9 Oct 2002 22:58:43 +0200
From: KELEMEN Peter <fuji@elte.hu>
To: linux-kernel@vger.kernel.org
Subject: Re: bondind 6 NICs
Message-ID: <20021009205843.GA20614@chiara.elte.hu>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20021009204920.6F0B74483@sitemail.everyone.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20021009204920.6F0B74483@sitemail.everyone.net>
User-Agent: Mutt/1.4i
Organization: ELTE Eotvos Lorand University of Sciences, Budapest, Hungary
X-GPG-KeyID: 1024D/EE4C26E8 2000-03-20
X-GPG-Fingerprint: D402 4AF3 7488 165B CC34  4147 7F0C D922 EE4C 26E8
X-PGP-KeyID: 1024/45F83E45 1998/04/04
X-PGP-Fingerprint: 26 87 63 4B 07 28 1F AD  6D AA B5 8A D6 03 0F BF
X-Comment: Personal opinion.  Paragraphs might have been reformatted.
X-Copyright: Forwarding or publishing without permission is prohibited.
X-Accept-Language: hu,en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Dionysio Calucci (dionysio@vr-zone.com) [20021009 13:49]:

> i achieved in bonding four NICs in every computer, but i cannot
> bond six NICs. The computer boots OK but it freezes when i start
> using the network.

That's actually much further than I managed.  2.4.19 completely
freezes when configuring the bonding interface (bond0), only power
cycle helps.  I'm trying to bond two 3Com Vortex cards together.

Peter

-- 
    .+'''+.         .+'''+.         .+'''+.         .+'''+.         .+''
 Kelemen Péter     /       \       /       \       /      fuji@elte.hu
.+'         `+...+'         `+...+'         `+...+'         `+...+'
