Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263897AbTE0Px0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 11:53:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263905AbTE0Px0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 11:53:26 -0400
Received: from va-leesburg1b-227.stngva.adelphia.net ([68.64.41.227]:11933
	"EHLO ccs.covici.com") by vger.kernel.org with ESMTP
	id S263897AbTE0PxZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 11:53:25 -0400
To: linux-kernel@vger.kernel.org
Cc: alsa-devel@lists.sourceforge.net
Subject: problems using via82xx with 2.5.69
From: John Covici <covici@ccs.covici.com>
Date: Tue, 27 May 2003 12:06:22 -0400
Message-ID: <m3llwsfk75.fsf@ccs.covici.com>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.  I compiled alsa as all modules using the ones provided in the
2.5.69 tree, but it loaded them and even though I have an
asound.state file which I use with the 2.4.20 kernel and the 0.9.3c
drivers, alsactl came up with two no information on control ... (I
think 37 and 38) no such file or directory, and no sound came out at
all -- all the volumes seemed to be at 0, even though the
asound.state file said otherwise, but I couldn't get anything even
though I tried to raise them using amixer.

What is happening here?

Any assistance would be appreciated.

-- 
         John Covici
         covici@ccs.covici.com
