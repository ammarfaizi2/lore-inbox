Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964808AbWJCO7I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964808AbWJCO7I (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 10:59:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964810AbWJCO7H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 10:59:07 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:65174 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S964808AbWJCO7F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 10:59:05 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Ns9T+ArtN17lwaaWzqz+hsZ+lBnY02JTjBA7qm8+EYpFnQFFmIFK9n4lKinIBaw4JhhxjIjQV/nRdS3zXzvpYm/XcHuoSAqG1e67JxF5c/Vwx0eGr+mk4kQjn2vFAo21PHcE7N0l5evtGw1TJ+/Zs6FrqVBJhoydujGc3pviFJ4=
Message-ID: <d4e708d60610030759h23a037aega70acb44bff1b524@mail.gmail.com>
Date: Tue, 3 Oct 2006 16:59:00 +0200
From: "koos vriezen" <koos.vriezen@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Linux 2.6.18 break scratchbox
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Hit by http://bugzilla.scratchbox.org/bugzilla/show_bug.cgi?id=279 I
wondered why such
a change that could break existing setups entered 2.6.18.
Now I can peek through '/proc/<pid of process outside chroot env w/ my
UID>/root' into the
box's root (and that's why scratchbox is broken now).
Regards,
Koos
