Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261960AbTE2HRm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 03:17:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261968AbTE2HRm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 03:17:42 -0400
Received: from va-leesburg1b-227.stngva.adelphia.net ([68.64.41.227]:52877
	"EHLO ccs.covici.com") by vger.kernel.org with ESMTP
	id S261960AbTE2HRl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 03:17:41 -0400
To: linux-kernel@vger.kernel.org
Subject: problem with beep in 2.5.70
From: John Covici <covici@ccs.covici.com>
Date: Thu, 29 May 2003 03:30:58 -0400
Message-ID: <m3wuga9pl9.fsf@ccs.covici.com>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have my console blength set to 80 and the frequency to 1800.

In 2.4.20 all is nice, but in 2.5.70 when ever a program beeps the
beep just keeps going, the only way to stop this is to issue a beep
command which seems to turn it off somehow.

Any assistance would be appreciated.

-- 
         John Covici
         covici@ccs.covici.com
