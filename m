Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262190AbTDENH1 (for <rfc822;willy@w.ods.org>); Sat, 5 Apr 2003 08:07:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262196AbTDENH0 (for <rfc822;linux-kernel-outgoing>); Sat, 5 Apr 2003 08:07:26 -0500
Received: from userk185.dsl.pipex.com ([62.188.58.185]:30595 "HELO
	userk185.dsl.pipex.com") by vger.kernel.org with SMTP
	id S262190AbTDENHZ (for <rfc822;linux-kernel@vger.kernel.org>); Sat, 5 Apr 2003 08:07:25 -0500
From: "Sean Hunter" <sean@uncarved.com>
Date: Sat, 5 Apr 2003 13:18:56 +0000
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Oops every write with ext3 + sync + data=journal
Message-ID: <20030405131856.GA5107@uncarved.com>
Mail-Followup-To: Sean Hunter <sean@uncarved.com>,
	Chuck Ebbert <76306.1226@compuserve.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <200304050525_MC3-1-331B-F7E4@compuserve.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200304050525_MC3-1-331B-F7E4@compuserve.com>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 05, 2003 at 05:24:40AM -0500, Chuck Ebbert wrote:
> Sean Hunter <sean@uncarved.com> wrote:
> 
> 
> >rw,sync,data=journal,nosuid,nodev
> 
> 
> Is there any good reason for using sync and data=journal together?

As I understood it (perhaps incorrectly) if you were mounting a drivE
"sync" data=journal was the way to go.

Perhaps that's wrong.

Sean
