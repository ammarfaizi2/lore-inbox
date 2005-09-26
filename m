Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751386AbVIZMBb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751386AbVIZMBb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 08:01:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751396AbVIZMBb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 08:01:31 -0400
Received: from qproxy.gmail.com ([72.14.204.201]:18660 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751386AbVIZMBb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 08:01:31 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=a1Ex9iyzg6J1KmWk9JapPfc34jQm5f55mEjNlMVUDBkx1ApRRAIwobdA9Bh3KbaFlMLa8EXtPpfQ64eGkIbG2Uggh4km01jHmJXcsz6E9QLUM7WJpU/XNRLQZKqR/f8BG9e4ul7xcwkj9GzZge9lxXVe3NnZB1DhLbPg0/ghKZk=
Message-ID: <907421f9050926050194c9ec@mail.gmail.com>
Date: Mon, 26 Sep 2005 05:01:30 -0700
From: mandy london <laborious.bee@gmail.com>
Reply-To: mandy london <laborious.bee@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: how about use hook() and timer() in the same moulde ?
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Does it has the chance proudcing double fault ?
