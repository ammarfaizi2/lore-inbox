Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932300AbVHKIdx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932300AbVHKIdx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 04:33:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932304AbVHKIdx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 04:33:53 -0400
Received: from wproxy.gmail.com ([64.233.184.199]:13160 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932300AbVHKIdw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 04:33:52 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=rGDjb+cNLt6w9y+DvnrGpdK+fUXfA7mH5VxW56RXLIy3xwP7lqe3h9CTMqwgc06ufFjRzSV6ogJtOB7aYX6zERs61NXoTXQ5+yexyGtMBE5L8sqCXAtimbRUwxEM61fawBUpHAVZwsoKa349+mkjU0NSLLC8i7qHkKdikfPxwDo=
Message-ID: <6b5347dc05081101334c1a6e3c@mail.gmail.com>
Date: Thu, 11 Aug 2005 16:33:51 +0800
From: n l <walking.to.remember@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: why the interrupt handler should be marked "static" for it is never called directly from another file.
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

could you explain its reason for using static ?
