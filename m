Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965170AbVHJP7s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965170AbVHJP7s (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 11:59:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965172AbVHJP7s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 11:59:48 -0400
Received: from eurogra4543-2.clients.easynet.fr ([212.180.52.86]:5570 "HELO
	briare1.heliogroup.fr") by vger.kernel.org with SMTP
	id S965170AbVHJP7s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 11:59:48 -0400
From: Hubert Tonneau <hubert.tonneau@fullpliant.org>
To: linux-kernel@vger.kernel.org
Subject: kernel.org git web interface
Date: Wed, 10 Aug 2005 15:59:02 GMT
Message-ID: <05BEHQE11@briare1.heliogroup.fr>
X-Mailer: Pliant 93
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The 'V' column on http://www.kernel.org/ is very convienient to review what
has changed in a new kernel (files list, then simple clic diff access to the
selected file).

Now, the git changelog is also interesting (provides overall explaination),
but it's harder to use because the changes stream is so dense.

So, what would be helpfull for reviewers is the ability to view the git
changelog of only the changes that touch a given file.
I mean when we select the 'V' column, have two links per modified file,
one displaying the diff has it currently does, and the other displaying
the git changes as 'C' column does, but filtered with only changes that
touch the selected file.

