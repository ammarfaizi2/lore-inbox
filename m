Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130020AbRBDWQJ>; Sun, 4 Feb 2001 17:16:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130079AbRBDWP7>; Sun, 4 Feb 2001 17:15:59 -0500
Received: from grunt.ksu.ksu.edu ([129.130.12.17]:1449 "EHLO
	mailhub.cns.ksu.edu") by vger.kernel.org with ESMTP
	id <S130020AbRBDWP4>; Sun, 4 Feb 2001 17:15:56 -0500
Date: Sun, 4 Feb 2001 16:15:54 -0600
From: Joseph Pingenot <jap3003@ksu.edu>
To: linux-kernel@vger.kernel.org
Subject: APM screen blanking
Message-ID: <20010204161554.A24588@ksu.edu>
Reply-To: jap3003+response@ksu.edu
Mail-Followup-To: linux-kernel@vger.kernel.org.
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
X-School: Kansas State University
X-vi-or-emacs: vi
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings.

Does anyone know what would cause a lockup when (2.4.x):
  * supsending to disk
  * changing from X to a virtual console
with APM enabled?  Changing from X to a VC functions when APM is
  compiled out.
Essentially, the screen blanks once and the machine locks up.
  Usually while suspending, the screen blanks at least twice.
  The 2.2.1[78] kernels work fine.
Has anyone else seen this behaviour?  I'm seeing this on a Toshiba 
  Satellite 1605CDS.
Thanks!

                              -Joseph

-- 
Joseph==============================================jap3003@ksu.edu
"I felt a great disturbance in the force.  As if a significant plot
  line suddenly cried out in terror... and was suddenly silenced."
                        -Torg in "Sluggy Freelance" www.sluggy.com.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
