Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262022AbUDSWmk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262022AbUDSWmk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 18:42:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261793AbUDSWmk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 18:42:40 -0400
Received: from smtp.dkm.cz ([62.24.64.34]:16909 "HELO smtp.dkm.cz")
	by vger.kernel.org with SMTP id S262022AbUDSWm2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 18:42:28 -0400
From: "Michal Semler (volny.cz)" <cijoml@volny.cz>
Reply-To: cijoml@volny.cz
To: linux-kernel@vger.kernel.org
Subject: standart events for hotkeys?
Date: Tue, 20 Apr 2004 00:42:24 +0200
User-Agent: KMail/1.6
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Message-Id: <200404200042.24671.cijoml@volny.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi guys,

I have a question related to keyboard and hotkeys.

Does any standart exist for hotkeys and their returned events?
I have 2 keyboards with hotkeys, one on laptop (acerhk operated) and one 
wireless (BlueZ bthid operated) and both returns different codes in xev when 
same keys are pressed

mail
browser
etc.

Maybe these should be standardised in all drivers? Can we start same kind of 
list, where will be all events stored and then translated by all drivers the 
same?

Now users can't use one hotkeys configuration on different keyboards so these 
could be renamed to hellkeys :)

Your opinions?

Michal
