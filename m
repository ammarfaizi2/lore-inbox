Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272830AbTG3JT6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 05:19:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272836AbTG3JT6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 05:19:58 -0400
Received: from smtp017.mail.yahoo.com ([216.136.174.114]:8198 "HELO
	smtp017.mail.yahoo.com") by vger.kernel.org with SMTP
	id S272830AbTG3JT6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 05:19:58 -0400
Date: Wed, 30 Jul 2003 06:22:45 -0300
From: Gerardo Exequiel Pozzi <vmlinuz386@yahoo.com.ar>
To: linux-kernel@vger.kernel.org
Cc: rusty@rustcorp.com.au
Subject: module-init-tools don't support gzipped modules.
Message-Id: <20030730062245.382c5dad.vmlinuz386@yahoo.com.ar>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i486-slackware-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi gurus,

The suite module-init-tools don´t support gzipped modules such as
modutils suite.
This not appears in the TODO list.

The possibility of compressing the modules is interesting, like for
example in cases of construction of small systems or initrd.

That you think about this?


-- 
Gerardo Exequiel Pozzi ( djgera )
http://www.vmlinuz.com.ar http://www.djgera.com.ar
KeyID: 0x1B8C330D
Key fingerprint = 0CAA D5D4 CD85 4434 A219  76ED 39AB 221B 1B8C 330D
