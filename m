Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265572AbTGCIkk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 04:40:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265581AbTGCIkk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 04:40:40 -0400
Received: from va-leesburg1b-227.chvlva.adelphia.net ([68.64.41.227]:46723
	"EHLO ccs.covici.com") by vger.kernel.org with ESMTP
	id S265572AbTGCIkj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 04:40:39 -0400
To: linux-kernel@vger.kernel.org
Subject: pc speaker support problem in 2.5.73
From: John Covici <covici@ccs.covici.com>
Date: Thu, 03 Jul 2003 04:55:04 -0400
Message-ID: <m3d6gsc7mf.fsf@ccs.covici.com>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In 2.5.73 (and even 70), I get the strange problem where if I have
pcspeaker support enabled under input, any program which beeps such
as emacs -- the beep won't stop unless I issue the actual beep
command while its still going and then the beep stops.

Any assistance would be appreciated.

-- 
         John Covici
         covici@ccs.covici.com
