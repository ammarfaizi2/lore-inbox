Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261584AbTDEAlS (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 19:41:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261572AbTDEAlS (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 19:41:18 -0500
Received: from jalon.able.es ([212.97.163.2]:8330 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id S261605AbTDEAkw (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Apr 2003 19:40:52 -0500
Date: Sat, 5 Apr 2003 02:52:16 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] thread signaling
Message-ID: <20030405005215.GE11904@werewolf.able.es>
References: <Pine.LNX.4.53L.0304041815110.32674@freak.distro.conectiva> <20030405004327.GA11141@werewolf.able.es>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="p2kqVDKq5asng8Dg"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030405004327.GA11141@werewolf.able.es>; from jamagallon@able.es on Sat, Apr 05, 2003 at 02:43:27 +0200
X-Mailer: Balsa 2.0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--p2kqVDKq5asng8Dg
Content-Type: text/plain; charset=ISO-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit


On 04.05, J.A. Magallon wrote:
> 
> On 04.04, Marcelo Tosatti wrote:
> > 
> > So here goes -pre7. Hopefully the last -pre.
> > 
> > Please try it.
> > 
> 

Fix bad signaling between threads when ancestor dies.
Author: Zeuner, Axel <Axel.Zeuner@partner.commerzbank.com>

-- 
J.A. Magallon <jamagallon@able.es>        \        Software is like sex:
werewolf.able.es                           \  It's better when it's free
Mandrake Linux release 9.2 (Bamboo) for i586
Linux 2.4.21-pre6-jam1 (gcc 3.2.2 (Mandrake Linux 9.1 3.2.2-3mdk))

--p2kqVDKq5asng8Dg
Content-Type: application/x-bzip
Content-Disposition: attachment; filename="005-self_exec_id.bz2"
Content-Transfer-Encoding: base64

QlpoOTFBWSZTWY9mo/kAAGRfgAAwSP///3zmCIC/79/qQAHaud1icNJpRk2o0AGTRkyDQDTE
ZDagBkQTCTR6FNDJ6jJoAAADRpoNU/SKeptQND1Gg9QAaAAAAASSEEno02ppqeUMmgNA00AA
xHqIBMQIYGkcNJKKWAgBQ/YhdtD8UJN6k6FrUYIwZkYVcAAmARMGFrN+BF0mYNSCfihiUB18
5lnQdtqxUA+gQ3QippdOjffJYusJZiXJPRbWIoyByiIQ8IZSQXBiBix6e+/fzsroZAYmW1bB
rMNzM7SWq5T6SUvBjdUGoJdba2UbBpA6YBKc6ZWQcTyByKW0ZUBlQlODZJMaoBEk5NDro7nl
wpgtANKFYs/KA84LzxGkwJ+wSKRQPBdwzCA2Ze+muMJRhKNO34xVIC/SEppdo+yz3AqXZWlG
Cuw5DEq2n7odctqHwkBqDL00qboAbNrq3+xs68pVXjQ2UHEBF1NAV5FGlsw8rGFFdRuaRY/j
C58QqtV9CzWgws4PsUX0BldJqCuYiDOBgGdNgkkmYMRoiwcoaJbSHATUWF7Z1PClYIUp1apD
KgF24PMI1Coi5HwKhL2TdjMMSTTKFiK2pNXo5L6WZQoRhbj3pPbaXF9zX2ZDv9QEMVKwHRN4
FpGFbQ7+LuSKcKEhHs1H8g==

--p2kqVDKq5asng8Dg--
