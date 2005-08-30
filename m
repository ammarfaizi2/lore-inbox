Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932136AbVH3Exy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932136AbVH3Exy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 00:53:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932142AbVH3Exy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 00:53:54 -0400
Received: from rproxy.gmail.com ([64.233.170.201]:46689 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932136AbVH3Exx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 00:53:53 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=XGOSZbe1vA48HCdYZObnEwayJh7keAW//YvJnEVP0/SqZ6l9ZQREhynaTESYojy2m9849bUJltEQGlhxL49JT6vMlZsG0n1YzYmd/JpZe8ECpC0gscJO6V50a3RIgJr5Dvd5Xq5vhSsAoKSWZyOclaP6r2j2yEL7pYxAV454Lo4=
Message-ID: <c3c37c55050829215355bb85f4@mail.gmail.com>
Date: Tue, 30 Aug 2005 12:53:51 +0800
From: jeff shia <xialinux@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: sr device can be written?
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
 Sr is the Scsi-cdrom device?so it can be read only?but look at the source=
=20
code I notice that
sr can be written also!Is it right?

Jeff
