Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261572AbTDEAmG (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 19:42:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261605AbTDEAmG (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 19:42:06 -0500
Received: from jalon.able.es ([212.97.163.2]:18570 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id S261572AbTDEAli (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Apr 2003 19:41:38 -0500
Date: Sat, 5 Apr 2003 02:53:02 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] detached clone
Message-ID: <20030405005302.GG11904@werewolf.able.es>
References: <Pine.LNX.4.53L.0304041815110.32674@freak.distro.conectiva> <20030405004327.GA11141@werewolf.able.es>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="J5MfuwkIyy7RmF4Q"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030405004327.GA11141@werewolf.able.es>; from jamagallon@able.es on Sat, Apr 05, 2003 at 02:43:27 +0200
X-Mailer: Balsa 2.0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--J5MfuwkIyy7RmF4Q
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

Fix a crash that can be caused by a CLONE_DETACHED thread.
Author: Ingo Molnar <mingo@elte.hu>

-- 
J.A. Magallon <jamagallon@able.es>        \        Software is like sex:
werewolf.able.es                           \  It's better when it's free
Mandrake Linux release 9.2 (Bamboo) for i586
Linux 2.4.21-pre6-jam1 (gcc 3.2.2 (Mandrake Linux 9.1 3.2.2-3mdk))

--J5MfuwkIyy7RmF4Q
Content-Type: application/x-bzip
Content-Disposition: attachment; filename="004-clone-detached.bz2"
Content-Transfer-Encoding: base64

QlpoOTFBWSZTWfXbfYEAADhfgFAwYX//s2zuSAC/rd5EMADpZhKUxNQPSAaNAyAaGjTCABKI
p5IxA00GmgAaAAA0EpKPSPTRDIBoAGgGTQDyhiWnhJ5rsF9936Ny4VYFNS8ItQjE8k9aPFmL
eNI9kGsykY5x5IZ2y3WQIjgUmVe3clk4vL0QrLQyMVp9QJ8eApJzSUJDWGijWx4hz9Yw1FUo
SgXYhCiZR0nTVMZTsMKTvU/QNlKHBVtJCQHkm5ItRXSShFbhFHf2E84Rjx4Ew4mD0fEaNFAs
MYyFICJBhdSUcokHjkaLAtDzDXIZCwJWGLPwkBKl9CNUQoqTCMHkCBS/+LuSKcKEh67b7Ag=

--J5MfuwkIyy7RmF4Q--
