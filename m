Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262497AbSJVNNQ>; Tue, 22 Oct 2002 09:13:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262523AbSJVNNQ>; Tue, 22 Oct 2002 09:13:16 -0400
Received: from d06lmsgate-4.uk.ibm.com ([195.212.29.4]:900 "EHLO
	d06lmsgate-4.uk.ibm.COM") by vger.kernel.org with ESMTP
	id <S262497AbSJVNNP>; Tue, 22 Oct 2002 09:13:15 -0400
Subject: dynamic probes vs kprobes
To: landley@trommello.org
Cc: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OF2BA226A6.4D51ABFF-ON80256C5A.004810FC@portsmouth.uk.ibm.com>
From: "Richard J Moore" <richardj_moore@uk.ibm.com>
Date: Tue, 22 Oct 2002 14:13:24 +0100
X-MIMETrack: Serialize by Router on D06ML023/06/M/IBM(Release 5.0.9a |January 7, 2002) at
 22/10/2002 14:19:21
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rob, are you happy with the distinction between dprobes and kprobes? We are
not proposing dprobes for 2.5 but rather kprobes + as many of the
incremental patches that Vamsi posted earlier. Altogether these amount to
the same thing as dprobes. All of these patches will be available from our
website.

If on the other hand, if  Linus wishes to integrate dprobes then we shan't
be disappointed :-)


Richard
RAS Project Lead - IBM Linux Technology Centre

