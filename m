Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315762AbSG1Lu2>; Sun, 28 Jul 2002 07:50:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315783AbSG1Lu2>; Sun, 28 Jul 2002 07:50:28 -0400
Received: from smtp.mujoskar.cz ([217.77.161.140]:19147 "EHLO smtp.mujoskar.cz")
	by vger.kernel.org with ESMTP id <S315762AbSG1Lu1>;
	Sun, 28 Jul 2002 07:50:27 -0400
Content-Type: text/plain; charset=US-ASCII
From: Michal Semler <cijoml@volny.cz>
Reply-To: cijoml@volny.cz
To: linux-kernel@vger.kernel.org
Subject: framebuffer problem in tdfx?
Date: Sun, 28 Jul 2002 13:52:36 +0200
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17YmbG-0000Ba-00@notas>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello I reported problem with tdfx framebuffer driver at Tue, 16 Jul 2002 
10:30:10 +0200
 
Now in 2.4.19-rc3 things become worser :(
When I switch into append="video=tdfx:1024x768-24@75" my console switch, 
penguin is still black-white, its background become black, but I CANT SEE ANY 
CHARACTERS WRITTEN ONTO CONSOLE. When I remove append and let console switch 
into 80x30, penguin is colored, but its background is white - not black and I 
can see characters written into console.

Could developer who will repair it send me patches and I'll tell him what 
happens.

Thanks a lot

Michal

