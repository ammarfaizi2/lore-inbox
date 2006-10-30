Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161095AbWJ3F2T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161095AbWJ3F2T (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 00:28:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161096AbWJ3F2T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 00:28:19 -0500
Received: from hu-out-0506.google.com ([72.14.214.230]:26159 "EHLO
	hu-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1161095AbWJ3F2T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 00:28:19 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=XKmea3PCPMs+zoz9sGiPYszJX577C4vbsRhZSVnYxyamTs3hYzSFDqsSZzIsgX9eRFXw1bCBzTodht37sy5rTM0VhcjjLNN/nlas7+uGXJstjeGMAuOGEnqX9qQb1gJZ/EqOVl7sdXsgJ7ZqkHWvSiWJ39AayKFwMvjByrMZ/cU=
Message-ID: <db74e4d30610292128yc4ccb8dpc4e185b85a85e3f3@mail.gmail.com>
Date: Mon, 30 Oct 2006 10:58:17 +0530
From: toka <atrockz@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: huge page access..
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi everyone,
   i am a kernel newbie, i wanted to know something about hugetlbfs.
     -   is huge pages only accessible to root user ?
     -   if so, when a process tries to accesses a huge pages, how
does  kernel checks if its an authorized User ID (or root user id) ?
