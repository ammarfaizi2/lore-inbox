Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264784AbTE1QMj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 12:12:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264788AbTE1QMj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 12:12:39 -0400
Received: from va-leesburg1b-227.stngva.adelphia.net ([68.64.41.227]:12164
	"EHLO ccs.covici.com") by vger.kernel.org with ESMTP
	id S264784AbTE1QMi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 12:12:38 -0400
To: linux-kernel@vger.kernel.org
Subject: peculiar alsa problems in 2.5.70
From: John Covici <covici@ccs.covici.com>
Date: Wed, 28 May 2003 12:25:54 -0400
Message-ID: <m38ysravhp.fsf@ccs.covici.com>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am using via82xx and I have all the alsa stuff configured as
modules and every time I do  /etc/init.d/alsasound start I get the
following:

Starting sound driver: snd-via82xx done
/usr/sbin/alsactl: set_control:780: failed to obtain info for control
#37 (No such file or directory)
/usr/sbin/alsactl: set_control:780: failed to obtain info for control
#38 (No such file or directory)
/usr/sbin/alsactl: set_control:780: failed to obtain info for control
#39 (No such file or directory)

Any assistance would be appreciated.

-- 
         John Covici
         covici@ccs.covici.com
