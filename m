Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313060AbSIPGno>; Mon, 16 Sep 2002 02:43:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313070AbSIPGno>; Mon, 16 Sep 2002 02:43:44 -0400
Received: from horkos.telenet-ops.be ([195.130.132.45]:1716 "EHLO
	horkos.telenet-ops.be") by vger.kernel.org with ESMTP
	id <S313060AbSIPGnn> convert rfc822-to-8bit; Mon, 16 Sep 2002 02:43:43 -0400
Content-Type: text/plain; charset=US-ASCII
From: Bart De Schuymer <bart.de.schuymer@pandora.be>
To: "David S. Miller" <davem@redhat.com>
Subject: [PATCH] ebtables - Ethernet bridge tables, for 2.5.35
Date: Mon, 16 Sep 2002 08:50:16 +0200
X-Mailer: KMail [version 1.4]
Cc: buytenh@math.leidenuniv.nl, linux-kernel@vger.kernel.org,
       ebtables-user@lists.sourceforge.net, bridge@math.leidenuniv.nl
References: <200209130520.41862.bart.de.schuymer@pandora.be> <200209130812.27093.bart.de.schuymer@pandora.be> <20020912.230916.96754743.davem@redhat.com>
In-Reply-To: <20020912.230916.96754743.davem@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200209160850.16192.bart.de.schuymer@pandora.be>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello David,

The following link points to the ebtables patch approved by Lennert:
http://users.pandora.be/bart.de.schuymer/ebtables/v2.0/ebtables-v2.0_vs_2.5.35-try3.diff

Changes:

cleanup brouter interface in the bridge code + brouter bugfix.

-- 
cheers,
Bart

