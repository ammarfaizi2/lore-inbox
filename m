Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261409AbVBLOtK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261409AbVBLOtK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Feb 2005 09:49:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261410AbVBLOtK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Feb 2005 09:49:10 -0500
Received: from rproxy.gmail.com ([64.233.170.203]:17093 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261409AbVBLOtF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Feb 2005 09:49:05 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=ZzMNjyfW8UIAOWe171RKIYsGxSF5aIswt3pGUZOHlUFEp7Adj2NbH6Qdwdv3fRFxhKqksFa6AOxusZJNKOxC5xIEC9VFJFPowD9W0HFiBiyrLHunYWqvvya8FlBtxKwoIgc8ZtECo+jKDJi4s/kmLOwRb29o8XJ/jkho1f8FCPc=
Message-ID: <5a4c581d0502120649423a2504@mail.gmail.com>
Date: Sat, 12 Feb 2005 15:49:05 +0100
From: Alessandro Suardi <alessandro.suardi@gmail.com>
Reply-To: Alessandro Suardi <alessandro.suardi@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.6.11-rc3-bk9 hangs hard my laptop
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dell Latitude C640, PIV @1.8Ghz, 1GB RAM, uptodate FC2

-bk7 (which I currently rebooted in) is okay.
-bk9 at first try got me to the login prompt, logged in, ran startx...
 frozen with the black background before seeing anything.

Second try hung well before, at the point where it switches the
 radeonfb on.

Only cure is to keep the power button pressed for 10".

Will try building -bk8 (which is currently running on my
 old desktop K7-800) and report...

--alessandro

  "There is no distance that I don't see
  I do have a will - No limit to my reach"
  
    (Wallflowers, "Empire In My Mind")
