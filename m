Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261366AbUCHWLT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 17:11:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261347AbUCHWLP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 17:11:15 -0500
Received: from nms.rz.uni-kiel.de ([134.245.1.2]:1263 "EHLO uni-kiel.de")
	by vger.kernel.org with ESMTP id S261370AbUCHWKX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 17:10:23 -0500
From: Mike Gabriel <mgabriel@ecology.uni-kiel.de>
Reply-To: mgabriel@ecology.uni-kiel.de
To: linux-kernel@vger.kernel.org
Subject: all people's firewire hds working?
Date: Mon, 8 Mar 2004 23:08:45 +0100
User-Agent: KMail/1.6
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Message-Id: <200403082308.45892.mgabriel@ecology.uni-kiel.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi there,

is anyone able to use firewire hds (mine is a notebook-ide-drive, 40gb, in 
real life) with kernel 2.6.3?

my syslog always complains:
> ieee1394: ConfigROM quadlet transaction error for node 00:1023 

if you google for this line, you find loads of posters having the same 
problem, but no one has provided them any answers.

thus, i wonder, if all the other ide firewire drives on this nice planet are 
working fine under 2.6.x ...

BTW: mine is with working fine under kernel 2.4.xx, but i tend to be 
progressive (i.e. 2.6.x-ish)

any ideas?

mike gabriel

-- 

Oekologiezentrum
Christian-Albrecht-Universität zu Kiel
- netzwerkteam -
Mike Gabriel
Olshausenstr 75.
24118 Kiel

fon: +49 431 880-1186
mail: mgabriel@ecology.uni-kiel.de
www: http://www.ecology.uni-kiel.de, http://zope.ecology.uni-kiel.de
     
