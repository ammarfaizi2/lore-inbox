Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261894AbTAYToK>; Sat, 25 Jan 2003 14:44:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261868AbTAYToJ>; Sat, 25 Jan 2003 14:44:09 -0500
Received: from beta.bandnet.com.br ([200.195.133.131]:271 "EHLO
	beta.bandnet.com.br") by vger.kernel.org with ESMTP
	id <S261894AbTAYToJ>; Sat, 25 Jan 2003 14:44:09 -0500
From: "User &" <breno_silva@beta.bandnet.com.br>
To: linux-kernel@vger.kernel.org
Subject: Expand Anonymous memory
Date: Sat, 25 Jan 2003 16:56:04 -0300
Message-Id: <20030125195604.M35901@beta.bandnet.com.br>
X-Mailer: Open WebMail 1.81 20021127
X-OriginatingIP: 200.215.42.52 (breno_silva)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi

people thanks for all sugestions.
So i am thinking expand just anonymous memory (vm_flags = NULL) , how do you 
think is the best away to share this memory between Linux A and B on the net ?
I have a source like mmap that create a anonymous memory space , but it can 
use just in local machine , and i´d like to share this space with another box.

thanks
Breno 
----------------------
WebMail Bandnet.com.br

