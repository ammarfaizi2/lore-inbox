Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261367AbTDHNK5 (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 09:10:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261376AbTDHNK5 (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 09:10:57 -0400
Received: from angband.namesys.com ([212.16.7.85]:49295 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP id S261367AbTDHNK5 (for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Apr 2003 09:10:57 -0400
Date: Tue, 8 Apr 2003 17:22:29 +0400
From: Oleg Drokin <green@namesys.com>
To: Jurriaan <thunder7@xs4all.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: cannot mount reiserfs-partition with 2.4.21-pre7 (works fine with 2.5.*)
Message-ID: <20030408172229.B12020@namesys.com>
References: <20030408104328.GA1264@middle.of.nowhere>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030408104328.GA1264@middle.of.nowhere>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Tue, Apr 08, 2003 at 12:43:28PM +0200, Jurriaan wrote:

> If there's anything I can do to help, please let me know.

Please show output of "fdisk -l /dev/hdd" and 
"debugreiserfs /dev/hdd2".
2.5 works fine because it lacks this new check (yet).

Thank you.

Bye,
    Oleg
